package alternativa.tanks.gui.category {
  import flash.events.Event;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class CategoryButtonsListEvent extends Event {
    public static const CATEGORY_SELECTED:String = "CategoryButtonsListEvent:CategorySelected";

    private var category:ItemViewCategoryEnum;

    public function CategoryButtonsListEvent(param1:String, param2:ItemViewCategoryEnum) {
      super(param1);
      this.category = param2;
    }

    public function getCategory() : ItemViewCategoryEnum {
      return this.category;
    }
  }
}
