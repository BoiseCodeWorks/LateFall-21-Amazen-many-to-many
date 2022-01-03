using LF21_Amazen.Services;
using Microsoft.AspNetCore.Mvc;

namespace LF21_Amazen.Controllers
{
  [ApiController]
  [Route("api/[controller]")]
  public class FavoriteProductsController : ControllerBase
  {
    private readonly FavoriteProductsService _service;

    public FavoriteProductsController(FavoriteProductsService service)
    {
      _service = service;
    }
  }
}
