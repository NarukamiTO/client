package alternativa.tanks.font.services {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.text.TextFormat;

  public class TanksFontsFormatServiceImpl implements TanksFontsFormatService {
    private var format:TextFormat;
    private var embedded:Boolean;

    public function TanksFontsFormatServiceImpl() {
      super();
      var local1:String = ILocaleService(OSGi.getInstance().getService(ILocaleService)).language;
      this.embedded = this.isEmbeddedFontsInLang(local1);
      this.format = this.getFontsFormatInLang(local1);
    }

    public function isEmbeddedFonts() : Boolean {
      return this.embedded;
    }

    public function getFontsFormat() : TextFormat {
      return this.format;
    }

    public function isEmbeddedFontsInLang(param1:String) : Boolean {
      return param1 != "cn" && param1 != "fa";
    }

    public function getFontsFormatInLang(param1:String) : TextFormat {
      var local2:TextFormat = null;
      switch(param1) {
        case "cn":
          local2 = new TextFormat("simsun");
          local2.indent = 0;
          break;
        case "fa":
          local2 = new TextFormat("IRANSans");
          local2.indent = 0;
          break;
        default:
          local2 = new TextFormat("MyriadPro",12,false);
      }
      local2.color = 16777215;
      return local2;
    }
  }
}
