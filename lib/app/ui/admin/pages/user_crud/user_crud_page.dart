import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/data/models/user_model.dart';
import 'package:segundo_muelle/app/ui/admin/pages/user_crud/user_crud__controller.dart';
import 'package:segundo_muelle/app/widgets/slidable_item.dart';

class UserCrudPage extends StatefulWidget {
  const UserCrudPage({Key? key}) : super(key: key);

  @override
  _UserCrudPageState createState() => _UserCrudPageState();
}

class _UserCrudPageState extends State<UserCrudPage> {
  final UserCrudController _userCrudController = Get.put(UserCrudController());

  Widget _buildUserItem({required UserModel user, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(user.name + DateTime.now().toString()),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Nombre y Apellido:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Nombre de usuario:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user.username,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Contraseña:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          user.password,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          user.isAdmin ? 'Administrador' : 'Mesero',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    if (user.isBlocked)
                      Row(
                        children: const [
                          Text(
                            'Usuario bloqueado',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(onDismissed: () {
            _userCrudController.onDeleteUser(index);
          }),
          children: [
            SlidableItem(
                backgroundColor: Colors.redAccent,
                onTap: () {
                  _userCrudController.onDeleteUser(index);
                },
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.white,
                )),
            SlidableItem(
                backgroundColor: Colors.blueAccent,
                onTap: () {
                  _userCrudController.onEditUser(index, user);
                },
                icon: const Icon(
                  Iconsax.edit,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Iconsax.arrow_left_2,
          color: Colors.black,
        ),
        iconSize: 16,
        tooltip: 'Retroceder',
        onPressed: () => Navigator.of(Get.context!).maybePop(),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      titleTextStyle:
      const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      toolbarTextStyle: const TextStyle(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actions: [
        IconButton(
          onPressed: () async {
            _userCrudController.onAddNewUser();
          },
          icon: const Icon(Iconsax.add),
          tooltip: 'Añadir usuario',
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Editar Usuarios'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEDF0F4),
      appBar: _buildAppBar(),
      body: Obx(() {
        if (_userCrudController.users.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: const [
                Icon(Iconsax.note_remove, size: 60, color: Colors.grey),
                SizedBox(height: 15),
                Text(
                  'Añade nuevos usuarios',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          );
        }
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 90),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._userCrudController.users
                          .asMap()
                          .map((index, element) {
                        return MapEntry(index,
                            _buildUserItem(user: element, index: index));
                      })
                          .values
                          .toList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
