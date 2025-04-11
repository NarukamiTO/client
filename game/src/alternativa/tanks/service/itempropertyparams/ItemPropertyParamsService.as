package alternativa.tanks.service.itempropertyparams {
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public interface ItemPropertyParamsService {
    function getParams(param1:ItemGarageProperty) : ItemPropertyParams;
  }
}
