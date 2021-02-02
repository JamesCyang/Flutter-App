
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/role_permission.dart';

class MyThirdPage extends StatefulWidget{
  MyThirdPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyThirdPageStage createState() => _MyThirdPageStage();
}

class _MyThirdPageStage extends State<MyThirdPage>{

  RolePermission rolePermission = RolePermission(voidOrder: true, cashManagement: false,  deleteTicketItem: false, makeCustomeDiscount: false, closeShift: false, charge: true, openCashDrawer: false, viewAnalyics: true , viewCachedRecord: true, viewSetting: false);
  Role role;
  final List<Role> roleList = [];

  @override
  void initState() {
    role = new Role(roleName: "Cashier", rolePermission:rolePermission);
    roleList.add(role);
    role = new Role(roleName: "Manager", rolePermission:rolePermission);
    roleList.add(role);
    role = new Role(roleName: "Waiter", rolePermission:rolePermission);
    roleList.add(role);
    role = new Role(roleName: "Kitchen", rolePermission:rolePermission);
    roleList.add(role);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Container(
         child: Wrap(
           alignment: WrapAlignment.center,
           spacing: 10.0,
           children: [
             ...createEachColumn()
           ],
         ),
      )
    );
  }

  List<Widget> createEachColumn(){
    final List<Widget> columns = [];
    columns.add(
      createFirstColumnWithEachRowTitle()
    );

    for(var role in roleList){
      columns.add(
        Column(
          children: [
            ...createRoleColumnWithEachRowPermission(role)
          ],
        )
      );
    }
    return columns;

  }

  Widget createFirstColumnWithEachRowTitle(){
    return Column(
      children: [
        Text(''),
        Text('voidOrder'),
        Text('viewSetting'),
        Text('viewCachedRecord'),
        Text('viewAnalyics'),
        Text('makeCustomeDiscount'),
        Text('cashManagement'),
        Text('closeShift'),
        Text('deleteTicketItem'),
        Text('charge'),
        Text('openCashDrawer')
      ],
    );
  }

  List<Widget> createRoleColumnWithEachRowPermission(Role role){
    List<Widget> eachRowList = [];
    eachRowList.add(
      Text(role.roleName)
    );

    Map<String, dynamic> rolePermissionList =  role.rolePermission.toJson();
    for(var rolePermission in rolePermissionList.entries){
      bool flag = rolePermission.value;
      eachRowList.add(
        IconButton(icon: Icon(flag ? Icons.check_circle : Icons.cancel ), onPressed: (){
          flag = !flag;
          rolePermissionList.update(rolePermission.key, (value) => flag);
          role.rolePermission = RolePermission.fromJson(rolePermissionList);
          setState(() {
          });
        }, color: flag ? Colors.green : Colors.red,)
      );
    }
    return eachRowList;
  }
}