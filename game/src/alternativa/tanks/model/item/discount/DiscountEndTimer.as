package alternativa.tanks.model.item.discount {
  import controls.timer.CountDownTimer;

  [ModelInterface]
  public interface DiscountEndTimer {
    function getEndDiscountTimer() : CountDownTimer;
  }
}
