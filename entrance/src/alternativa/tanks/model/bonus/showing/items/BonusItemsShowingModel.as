package alternativa.tanks.model.bonus.showing.items {
  import alternativa.tanks.gui.CongratulationsWindowWithBanner;
  import alternativa.tanks.gui.RepatriateBonusWindow;
  import alternativa.tanks.model.bonus.showing.info.BonusInfo;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemsShowingCC;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemsShowingModelBase;
  import projects.tanks.client.panel.model.bonus.showing.items.IBonusItemsShowingModelBase;

  [ModelInfo]
  public class BonusItemsShowingModel extends BonusItemsShowingModelBase implements IBonusItemsShowingModelBase, ObjectLoadListener {
    public function BonusItemsShowingModel() {
      super();
    }

    public function objectLoaded() : void {
      var local3:IGameObject = null;
      var local4:BonusInfo = null;
      var local1:BonusItemsShowingCC = getInitParam();
      var local2:Vector.<BonusItemCC> = new Vector.<BonusItemCC>();
      for each(local3 in local1.bonuses) {
        local2.push(BonusItem(local3.adapt(BonusItem)).getItem());
      }
      local4 = BonusInfo(object.adapt(BonusInfo));
      if(local4.getImage() == null) {
        new CongratulationsWindowWithBanner(object,local4.getTopText(),local2);
      } else {
        new RepatriateBonusWindow(object,local4.getImage().data,local4.getTopText(),local2);
      }
    }
  }
}
