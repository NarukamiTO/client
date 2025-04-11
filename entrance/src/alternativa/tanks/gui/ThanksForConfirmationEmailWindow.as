package alternativa.tanks.gui {
  import controls.base.DefaultButtonBase;
  import flash.events.MouseEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class ThanksForConfirmationEmailWindow extends EmailReminderWindow {
    public function ThanksForConfirmationEmailWindow() {
      super();
      addCautionImage(confirmEmailReminderBitmapData);
      addCautionLabel(localeService.getText(TanksLocale.TEXT_ALERT_CRYSTALS_ADDED_FOR_CONFIRMED_EMAIL));
      this.addCloseButton();
      setWindowSize();
      show();
    }

    private function addCloseButton() : void {
      closeButton = new DefaultButtonBase();
      closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      closeButton.x = WINDOW_WIDTH - WINDOW_MARGIN - closeButton.width;
      closeButton.y = labelInnerWindow.y + labelInnerWindow.height + GAP;
      closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      window.addChild(closeButton);
    }

    override protected function onCloseButtonClick(param1:MouseEvent = null) : void {
      closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      dispatchEvent(new EnterEmailReminderWindowEvent(EnterEmailReminderWindowEvent.WINDOW_CLOSING));
      dialogService.removeDialog(this);
    }

    override protected function confirmationKeyPressed() : void {
      this.onCloseButtonClick();
    }
  }
}
