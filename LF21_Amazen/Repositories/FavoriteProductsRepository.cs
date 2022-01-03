using System.Collections.Generic;
using System.Data;
using System.Linq;
using Dapper;
using LF21_Amazen.Models;

namespace LF21_Amazen.Repositories
{
  public class FavoriteProductsRepository
  {
    private readonly IDbConnection _db;

    public FavoriteProductsRepository(IDbConnection db)
    {
      _db = db;
    }

    public List<FavoriteProduct> GetMyFavorites(string id)
    {
      // NOTE WHY does the order of this select matter?
      string sql = @"
SELECT
  p.*,
  fp.id AS favoriteProductId,
  a.*
FROM favoriteProduct fp
  JOIN productz p ON fp.productId = p.id
  JOIN accounts a ON fp.accountId = a.id
WHERE fp.accountId = @id;";
      return _db.Query<FavoriteProduct, Account, FavoriteProduct>(sql, (product, account) =>
      {
        product.Account = account;
        return product;
      }, new { id }, splitOn: "id").ToList();
    }
  }
}