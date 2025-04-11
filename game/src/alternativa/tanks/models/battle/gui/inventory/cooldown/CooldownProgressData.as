package alternativa.tanks.models.battle.gui.inventory.cooldown {
  public class CooldownProgressData {
    [Obfuscation(rename="false")]
    public var progress:Number;

    [Obfuscation(rename="false")]
    public var fillProgress:Number;

    [Obfuscation(rename="false")]
    public var addingProgress:Number;

    public function CooldownProgressData() {
      super();
      this.reset();
    }

    public function reset() : void {
      this.progress = 1;
      this.fillProgress = 1;
      this.addingProgress = 1;
    }
  }
}
