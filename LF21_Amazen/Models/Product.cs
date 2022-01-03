namespace LF21_Amazen.Models
{
  public class Product
  {
    public int Id { get; set; }
    public string Name { get; set; }
    public double Price { get; set; }
    public bool InStock { get; set; }

  }

  public class FavoriteProduct : Product
  {
    public int FavoriteProductId { get; set; }
    public Account Account { get; set; }
  }
}