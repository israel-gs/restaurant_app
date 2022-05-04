import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segundo_muelle/app/data/models/table_model.dart';
import 'package:segundo_muelle/app/ui/admin/pages/table_crud/table_crud__controller.dart';
import 'package:segundo_muelle/app/widgets/slidable_item.dart';

class TableCrudPage extends StatefulWidget {
  const TableCrudPage({Key? key}) : super(key: key);

  @override
  _TableCrudPageState createState() => _TableCrudPageState();
}

class _TableCrudPageState extends State<TableCrudPage> {
  final TableCrudController _tableCrudController =
      Get.put(TableCrudController());

  Widget _buildTableItem({required TableModel table, required int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Slidable(
        key: ValueKey(table.name + DateTime.now().toString()),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      children: [Text(table.name)],
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
            _tableCrudController.onDeleteTable(index);
          }),
          children: [
            SlidableItem(
                backgroundColor: Colors.redAccent,
                onTap: () {
                  _tableCrudController.onDeleteTable(index);
                },
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.white,
                )),
            SlidableItem(
                backgroundColor: Colors.blueAccent,
                onTap: () {
                  _tableCrudController.onEditTable(index, table);
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
            _tableCrudController.onAddNewTable();
          },
          icon: const Icon(Iconsax.add),
          tooltip: 'Añadir mesa',
        )
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Editar Mesas'),
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 90),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._tableCrudController.tables
                            .asMap()
                            .map((index, element) {
                              return MapEntry(
                                  index,
                                  _buildTableItem(
                                      table: element, index: index));
                            })
                            .values
                            .toList(),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
