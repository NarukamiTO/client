package alternativa.tanks.models.weapon.healing {
  import alternativa.engine3d.core.Object3DContainer;
  import alternativa.engine3d.materials.TextureMaterial;

  public class HealingGunBuffedBeam extends Object3DContainer {
    private var streamHeal:HealingGunStream = new HealingGunStream(128,0,0);
    private var streamHeal2:HealingGunStream = new HealingGunStream(90,-60,Math.PI / 3);
    private var streamHeal3:HealingGunStream = new HealingGunStream(90,60,Math.PI * 2 / 3);

    public function HealingGunBuffedBeam() {
      super();
      this.streamHeal.init();
      this.streamHeal2.init();
      this.streamHeal3.init();
      addChild(this.streamHeal2);
      addChild(this.streamHeal3);
      addChild(this.streamHeal);
    }

    public function setMaterial(param1:TextureMaterial, param2:int) : void {
      this.streamHeal.setMaterial(param1,param2);
      this.streamHeal2.setMaterial(param1,param2);
      this.streamHeal3.setMaterial(param1,param2);
    }

    public function update(param1:int, param2:Number) : void {
      this.streamHeal.update(param1,param2);
      this.streamHeal2.update(param1,param2);
      this.streamHeal3.update(param1,param2);
    }
  }
}
