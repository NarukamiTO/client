package alternativa.init {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.tanks.font.services.TanksFontsFormatService;
  import alternativa.tanks.font.services.TanksFontsFormatServiceImpl;
  import flash.text.Font;
  import fonts.TanksFontService;

  public class TanksFontsActivator implements IBundleActivator {
    private static const MyriadPro:Class = TanksFontsActivator_MyriadPro;
    private static const MyriadProB:Class = TanksFontsActivator_MyriadProB;
    private static const IRANSansWeb:Class = TanksFontsActivator_IRANSansWeb;
    private static const IRANSansWebB:Class = TanksFontsActivator_IRANSansWebB;
    private static const IRANYekanB:Class = TanksFontsActivator_IRANYekanB;

    public function TanksFontsActivator() {
      super();
    }

    public function start(param1:OSGi) : void {
      Font.registerFont(MyriadPro);
      Font.registerFont(MyriadProB);
      Font.registerFont(IRANSansWeb);
      Font.registerFont(IRANSansWebB);
      Font.registerFont(IRANYekanB);
      var local2:TanksFontsFormatServiceImpl = new TanksFontsFormatServiceImpl();
      param1.registerService(TanksFontsFormatService,local2);
      TanksFontService.setTextFormat(local2.getFontsFormat(),local2.isEmbeddedFonts());
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
