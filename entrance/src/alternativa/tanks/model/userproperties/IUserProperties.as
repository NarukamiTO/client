package alternativa.tanks.model.userproperties {
  import alternativa.types.Long;

  [ModelInterface]
  public interface IUserProperties {
    function getId() : Long;
    function getName() : String;
    function getScore() : int;
    function getRank() : int;
    function getNextScore() : int;
    function getPlace() : int;
  }
}
