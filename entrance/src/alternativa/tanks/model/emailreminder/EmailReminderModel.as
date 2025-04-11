package alternativa.tanks.model.emailreminder {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.gui.EmailBlockRequestEvent;
  import alternativa.tanks.gui.EmailReminderWindow;
  import alternativa.tanks.gui.EnterEmailReminderWindowEvent;
  import alternativa.tanks.gui.ThanksForConfirmationEmailWindow;
  import alternativa.tanks.service.panel.IPanelView;
  import alternativa.tanks.service.settings.ISettingsService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.panel.model.emailreminder.EmailReminderModelBase;
  import projects.tanks.client.panel.model.emailreminder.IEmailReminderModelBase;

  [ModelInfo]
  public class EmailReminderModel extends EmailReminderModelBase implements IEmailReminderModelBase, ObjectLoadListener, ObjectUnloadListener, EmailReminderService {
    [Inject]
    public static var panelView:IPanelView;

    [Inject]
    public static var settingsService:ISettingsService;

    private var window:EmailReminderWindow;

    public function EmailReminderModel() {
      super();
    }

    public function objectLoaded() : void {
      OSGi.getInstance().registerService(EmailReminderService,object.adapt(EmailReminderService));
    }

    public function openEnterEmailReminder() : void {
      this.createEmailReminderWindow();
      this.window.showEnterEmailReminder();
    }

    public function openConfirmEmailReminder(param1:String) : void {
      this.createEmailReminderWindow();
      this.window.showConfirmEmailReminder(param1);
    }

    public function openThanksForConfirmationEmailWindow() : void {
      new ThanksForConfirmationEmailWindow();
    }

    private function createEmailReminderWindow() : void {
      this.window = new EmailReminderWindow();
      this.window.addEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
      this.window.addEventListener(EnterEmailReminderWindowEvent.EMAIL_CONFIRMATION,getFunctionWrapper(this.onEmailConfirmation));
      this.window.addEventListener(EnterEmailReminderWindowEvent.EMAIL_SAVING_AND_CONFIRMATION,getFunctionWrapper(this.onEmailSavingAndConfirmation));
      this.window.addEventListener(EnterEmailReminderWindowEvent.WINDOW_CLOSING,getFunctionWrapper(this.onWindowClosing));
    }

    private function onWindowClosing(param1:EnterEmailReminderWindowEvent) : void {
      this.window.removeEventListener(EmailBlockRequestEvent.SEND_VALIDATE_EMAIL_REQUEST_EVENT,getFunctionWrapper(this.onValidateEmail));
      this.window.removeEventListener(EnterEmailReminderWindowEvent.EMAIL_CONFIRMATION,getFunctionWrapper(this.onEmailConfirmation));
      this.window.removeEventListener(EnterEmailReminderWindowEvent.EMAIL_SAVING_AND_CONFIRMATION,getFunctionWrapper(this.onEmailSavingAndConfirmation));
      this.window.removeEventListener(EnterEmailReminderWindowEvent.WINDOW_CLOSING,getFunctionWrapper(this.onWindowClosing));
      this.window = null;
    }

    private function onEmailSavingAndConfirmation(param1:EnterEmailReminderWindowEvent) : void {
      settingsService.setEmail(param1.email,false);
      server.setAndConfirmEmail(param1.email);
    }

    private function onEmailConfirmation(param1:EnterEmailReminderWindowEvent) : void {
      server.confirmEmail();
    }

    private function onValidateEmail(param1:EmailBlockRequestEvent) : void {
      server.validateEmail(param1.email);
    }

    public function notifyEmailIsBusy(param1:String) : void {
      this.window.showEmailIsBusy(param1);
    }

    public function notifyEmailIsForbidden(param1:String) : void {
      this.window.showEmailIsForbidden(param1);
    }

    public function notifyEmailIsFree(param1:String) : void {
      this.window.showEmailIsFree(param1);
    }

    public function activateMessage(param1:String) : void {
      panelView.showAlert(param1);
    }

    public function showEmailReminder() : void {
      if(!settingsService.isEmailSet()) {
        this.openEnterEmailReminder();
        return;
      }
      if(!settingsService.isEmailConfirmed()) {
        this.openConfirmEmailReminder(settingsService.getEmail());
      }
    }

    public function showNeedEmailAlert() : void {
      this.createEmailReminderWindow();
      this.window.showNeedEmailAlert();
    }

    public function objectUnloaded() : void {
      OSGi.getInstance().unregisterService(EmailReminderService);
    }
  }
}
