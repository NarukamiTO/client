package alternativa.tanks.model.garage.present {
  import alternativa.model.description.IDescription;
  import alternativa.tanks.model.item.buyable.IBuyable;
  import alternativa.tanks.model.item.category.IItemCategory;
  import alternativa.tanks.model.item.category.IItemViewCategory;
  import alternativa.tanks.model.item.item.IItem;
  import alternativa.tanks.model.item.present.PresentImage;
  import alternativa.tanks.model.item.present.UserPresent;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.impl.Component;
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;
  import projects.tanks.client.garage.models.user.present.PresentItem;

  public class UserPresentComponent extends Component implements UserPresent, IItemCategory, IItemViewCategory, PresentImage, IDescription, IBuyable, IItem {
    private var present:PresentItem;

    public function UserPresentComponent(param1:PresentItem) {
      super();
      this.present = param1;
    }

    public function getText() : String {
      return this.present.text;
    }

    public function getPresenterId() : Long {
      return this.present.presenter;
    }

    public function getDate() : Date {
      return this.present.date;
    }

    public function getCategory() : ItemCategoryEnum {
      return ItemCategoryEnum.GIVEN_PRESENT;
    }

    public function getViewCategory() : ItemViewCategoryEnum {
      return ItemViewCategoryEnum.GIVEN_PRESENTS;
    }

    public function getImage() : ImageResource {
      return PresentImage(this.present.present.adapt(PresentImage)).getImage();
    }

    public function getName() : String {
      return IDescription(this.present.present.adapt(IDescription)).getName();
    }

    public function getDescription() : String {
      return IDescription(this.present.present.adapt(IDescription)).getDescription();
    }

    public function getPriceWithoutDiscount() : int {
      return 0;
    }

    public function getPrice() : int {
      return 0;
    }

    public function isBuyable() : Boolean {
      return false;
    }

    public function getPosition() : int {
      return 0;
    }

    public function getPreviewResource() : ImageResource {
      return IItem(this.present.present.adapt(IItem)).getPreviewResource();
    }

    public function getMaxRank() : int {
      return 1;
    }

    public function getMinRank() : int {
      return 1;
    }
  }
}
