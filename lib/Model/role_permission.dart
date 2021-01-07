
class Role{
  String roleName;
  RolePermission rolePermission;

  Role({
   this.roleName, this.rolePermission
  });
}

class RolePermission{
  bool voidOrder,
      viewSetting,
      viewCachedRecord,
      viewAnalyics,
      makeCustomeDiscount,
      cashManagement,
      closeShift,
      deleteTicketItem,
      charge,
      openCashDrawer;

  RolePermission({
    this.voidOrder,
    this.viewSetting,
    this.viewCachedRecord,
    this.viewAnalyics,
    this.makeCustomeDiscount,
    this.cashManagement,
    this.closeShift,
    this.deleteTicketItem,
    this.charge,
    this.openCashDrawer
  });

  Map<String, dynamic> toJson() => {
        'voidOrder': voidOrder,
        'viewSetting': viewSetting,
        'viewCachedRecord': viewCachedRecord,
        'viewAnalyics': viewAnalyics,
        'makeCustomeDiscount': makeCustomeDiscount,
        'cashManagement': cashManagement,
        'closeShift': closeShift,
        'deleteTicketItem': deleteTicketItem,
        'charge': charge,
        'openCashDrawer': openCashDrawer
      };

  factory RolePermission.fromJson(Map<String, dynamic> json) =>
      RolePermission(
        voidOrder: json['voidOrder'],
        viewSetting: json['viewSetting'],
        viewCachedRecord: json['viewCachedRecord'],
        viewAnalyics: json['viewAnalyics'],
        makeCustomeDiscount: json['makeCustomeDiscount'],
        cashManagement: json['cashManagement'],
        closeShift: json['closeShift'],
        deleteTicketItem: json['deleteTicketItem'],
        charge: json['charge'],
        openCashDrawer: json['openCashDrawer'],
      );
}