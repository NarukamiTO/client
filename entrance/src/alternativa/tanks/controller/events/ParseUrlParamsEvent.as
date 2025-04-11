package alternativa.tanks.controller.events {
  import flash.events.Event;

  public class ParseUrlParamsEvent extends Event {
    public static const PARSE_URL_PARAMS_EVENT:String = "PARSE_URL_PARAMS_EVENT";

    public function ParseUrlParamsEvent() {
      super(PARSE_URL_PARAMS_EVENT);
    }
  }
}
