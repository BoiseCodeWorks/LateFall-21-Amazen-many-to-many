using System.Collections.Generic;
using LF21_Amazen.Models;
using LF21_Amazen.Repositories;

namespace LF21_Amazen.Services
{
  public class FavoriteProductsService
  {
    private readonly FavoriteProductsRepository _repo;

    public FavoriteProductsService(FavoriteProductsRepository repo)
    {
      _repo = repo;
    }

    public List<FavoriteProduct> GetMyFavorites(string id)
    {
      return _repo.GetMyFavorites(id);
    }
  }
}