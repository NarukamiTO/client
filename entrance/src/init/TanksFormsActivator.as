package init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.alertservices.IAlertService;
  import services.alertservice.AlertService;
  import services.buttonbar.ButtonBarService;
  import services.buttonbar.IButtonBarService;
  import services.contextmenu.ContextMenuService;
  import services.contextmenu.IContextMenuService;

  public class TanksFormsActivator implements IBundleActivator {
    public function TanksFormsActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      param1.registerService(IContextMenuService,new ContextMenuService());
      param1.registerService(IButtonBarService,new ButtonBarService());
      param1.registerService(IAlertService,new AlertService());
    }

    public function stop(param1:OSGi) : void {
      param1.unregisterService(IContextMenuService);
      param1.unregisterService(IButtonBarService);
      param1.unregisterService(IAlertService);
    }
  }
}
