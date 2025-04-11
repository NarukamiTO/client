package alternativa.tanks.model.bonus.showing.items {
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemModelBase;
  import projects.tanks.client.panel.model.bonus.showing.items.IBonusItemModelBase;

  [ModelInfo]
  public class BonusItemModel extends BonusItemModelBase implements IBonusItemModelBase, BonusItem {
    public function BonusItemModel() {
      super();
    }

    public function getItem() : BonusItemCC {
      return getInitParam();
    }
  }
}
