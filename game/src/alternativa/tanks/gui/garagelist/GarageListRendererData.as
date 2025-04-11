package alternativa.tanks.gui.garagelist {
  import controls.timer.CountDownTimer;
  import flash.display.DisplayObject;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class GarageListRendererData {
    public var id:IGameObject;
    public var name:String;
    public var type:ItemCategoryEnum;
    public var mod:int;
    public var crystalPrice:int;
    public var rank:int;
    public var showLockPremium:Boolean;
    public var installed:Boolean;
    public var garageElement:Boolean;
    public var count:int;
    public var preview:ImageResource;
    public var sort:int;
    public var discount:int;
    public var timerDiscount:CountDownTimer;
    public var iconNormal:DisplayObject;
    public var iconSelected:DisplayObject;
    public var label:String = "";
    public var icon:DisplayObject;
    public var source:*;
    public var appearanceTime:Number;

    public function GarageListRendererData() {
      super();
    }
  }
}
