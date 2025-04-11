package alternativa.tanks.models.teamlight {
  public final class TeamLightColor {
    private var color:uint;
    private var intensity:Number;

    public function TeamLightColor(param1:uint, param2:Number) {
      super();
      this.color = param1;
      this.intensity = param2;
    }

    public function getColor() : uint {
      return this.color;
    }

    public function getIntensity() : Number {
      return this.intensity;
    }
  }
}
