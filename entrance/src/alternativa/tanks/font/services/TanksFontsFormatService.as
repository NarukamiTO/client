package alternativa.tanks.font.services {
  import flash.text.TextFormat;

  public interface TanksFontsFormatService {
    function isEmbeddedFonts() : Boolean;
    function getFontsFormat() : TextFormat;
    function isEmbeddedFontsInLang(param1:String) : Boolean;
    function getFontsFormatInLang(param1:String) : TextFormat;
  }
}
