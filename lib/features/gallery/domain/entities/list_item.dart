import 'package:alexis_art/features/gallery/domain/entities/year_header.dart';
import 'package:alexis_art/features/gallery/domain/entities/picture.dart';
import 'package:meta/meta.dart';

class ListItem {
  Picture picture;
  YearHeader yearHeader;
  ListItemType listItemType;

  ListItem.picture({
    @required this.picture,
  }) : listItemType = ListItemType.PICTURE;

  ListItem.yearHeader({
    @required this.yearHeader,
  }) : listItemType = ListItemType.YEAR_HEADER;
}

enum ListItemType { PICTURE, YEAR_HEADER}
