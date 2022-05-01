import 'package:flutter/material.dart';
import 'package:segundo_muelle/app/ui/theme/color_theme.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String acceptButtonText;
  final VoidCallback? onAccept;
  final String? denyButtonText;
  final VoidCallback? onDeny;
  final Widget? titleContent;
  final Widget? subtitleContent;

  ConfirmationDialog(
      {required this.title,
      required this.subtitle,
      required this.acceptButtonText,
      required this.onAccept,
      this.denyButtonText,
      this.onDeny,
      this.titleContent,
      this.subtitleContent});

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: ColorTheme.primary, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSubtitle(String subtitle) {
    return Text(
      subtitle,
      style: const TextStyle(
          color: Colors.black38, fontSize: 18, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      titlePadding:
          const EdgeInsets.only(top: 22, left: 20, right: 20, bottom: 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: titleContent ?? _buildTitle(title),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          subtitleContent ?? _buildSubtitle(subtitle),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.end,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        (denyButtonText != null && denyButtonText!.isNotEmpty)
                            ? TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                ),
                                onPressed: onDeny,
                                child: Text(
                                  denyButtonText ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ColorTheme.primary),
                                ))
                            : Container(),
                        (acceptButtonText.isNotEmpty)
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                  ),
                                ),
                                onPressed: onAccept,
                                child: Text(
                                  acceptButtonText,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            : Container(),
                        /*(denyButtonText != null && denyButtonText!.isNotEmpty)
                            ? new SecondaryButtonWidget(
                                small: true,
                                label: denyButtonText,
                                onPressed: onDeny,
                              )
                            : Container(),
                        (acceptButtonText.isNotEmpty)
                            ? new PrimaryButtonWidget(
                                small: true,
                                label: acceptButtonText,
                                onPressed: onAccept,
                              )
                            : Container()*/
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
