package projects.tanks.client.tanksservices.model.uidcheck {
  import platform.client.models.commons.types.ValidationStatus;

  public interface IUidCheckModelBase {
    function validateResult(param1:ValidationStatus) : void;
  }
}
