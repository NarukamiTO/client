package platform.clients.fp10.libraries.alternativapartners.type {
  import platform.client.core.general.socialnetwork.types.LoginParameters;

  [ModelInterface]
  public interface IParametersListener {
    function onSetParameters(param1:LoginParameters) : void;
    function onFailSetParameters() : void;
  }
}
