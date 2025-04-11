package alternativa.tanks.model.promo {
  import alternativa.tanks.gui.shop.payment.promo.PromoCodeActivateForm;

  [ModelInterface]
  public interface ShopPromoCode {
    function getForm() : PromoCodeActivateForm;
  }
}
