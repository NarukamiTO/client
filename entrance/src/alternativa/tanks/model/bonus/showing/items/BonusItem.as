package alternativa.tanks.model.bonus.showing.items {
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;

  [ModelInterface]
  public interface BonusItem {
    function getItem() : BonusItemCC;
  }
}
