package alternativa.tanks.model.quest.challenge.stars {
  import alternativa.tanks.service.panel.IPanelView;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.panel.model.challenge.stars.IStarsInfoModelBase;
  import projects.tanks.client.panel.model.challenge.stars.StarsInfoModelBase;

  [ModelInfo]
  public class StarsInfoModel extends StarsInfoModelBase implements IStarsInfoModelBase, ObjectLoadListener {
    [Inject]
    public static var starsInfoService:StarsInfoService;

    [Inject]
    public static var panelView:IPanelView;

    public function StarsInfoModel() {
      super();
    }

    public function objectLoaded() : void {
      starsInfoService.setStars(getInitParam().stars);
    }

    public function setStars(param1:int) : void {
      starsInfoService.setStars(param1);
    }
  }
}
