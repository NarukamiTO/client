package alternativa.tanks.models.battle.battlefield.map {
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.objects.Mesh;

  public class NormalsCalculator {
    private static var map:Object;

    private static const propNames:Array = ["hang_1","hang_2","hang_3","SmHouse008","wall_broke_1","wall_broke_2","Bk_roof1","Bk_roof2","Tree01","Tree02","tube_1","tube_2","tube_3","tube_cor","cliff_3","cliff_1","cliff_2","cliff_4","cliff_inco","cliff_cor","cliff_r2","cliff_ri","Big_Rock04","Big_Rock","Change01","Change02","Corn1","Corn2","Corn3","Corn4","Corn_B","crater","Land02","Land03","Land04","Land05","Land06","Land07","Land08","Land09","Land22","Land33","Line","Med_Rock","rise_g1","rise_g2","rise_g3","rise_g4","rise_g5","rise_g6","Rise_gr1","Rise_gr2","rise_r1","sm_rock1","sm_rock2","up_Brock","Up_Rock","Up_Rock1","Up_Rock2","Up_Rock14"];

    public function NormalsCalculator() {
      var local1:String = null;
      super();
      if(map == null) {
        map = {};
        for each(local1 in propNames) {
          map[local1] = true;
        }
      }
    }

    public function calculateNormals(param1:Vector.<Object3D>) : void {
      this.clearSmoothingGroups(param1);
      Mesh.calculateVerticesNormalsBySmoothingGroupsForMeshList(param1,0.01);
    }

    private function clearSmoothingGroups(param1:Vector.<Object3D>) : void {
      var local2:Object3D = null;
      var local3:Mesh = null;
      var local4:Face = null;
      for each(local2 in param1) {
        if(map[local2.name] == null) {
          local3 = local2 as Mesh;
          for each(local4 in local3.faces) {
            local4.smoothingGroups = 0;
          }
        }
      }
    }
  }
}
