package alternativa.tanks.battle.scene3d {
  import alternativa.engine3d.objects.Decal;

  public class DecalEntry {
    public var decal:Decal;
    public var startTime:int;

    public function DecalEntry(param1:Decal, param2:int) {
      super();
      this.decal = param1;
      this.startTime = param2;
    }
  }
}
