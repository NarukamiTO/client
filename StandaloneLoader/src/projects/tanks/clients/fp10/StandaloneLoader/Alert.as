package projects.tanks.clients.fp10.StandaloneLoader {
  import flash.html.HTMLLoader;

  public class Alert {
    private static var htmlLoader:HTMLLoader;

    private static const html:String = "<!DOCTYPE html><html lang=\'en\'><head><meta charset=\'utf-8\'>" + "<title>Tanki Online</title><script></script></head><body></body></html>";

    public function Alert() {
      super();
    }

    public static function showMessage(message:String) : void {
      if(htmlLoader == null) {
        htmlLoader = new HTMLLoader();
        htmlLoader.loadString(html);
      }
      htmlLoader.window.alert(message);
    }
  }
}
