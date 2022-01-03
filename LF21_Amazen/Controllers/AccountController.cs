using System;
using System.Threading.Tasks;
using LF21_Amazen.Models;
using LF21_Amazen.Services;
using CodeWorks.Auth0Provider;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace LF21_Amazen.Controllers
{
  [ApiController]
  [Route("[controller]")]
  public class AccountController : ControllerBase
  {
    private readonly AccountService _accountService;
    private readonly FavoriteProductsService _fpService;

    public AccountController(AccountService accountService, FavoriteProductsService fpService)
    {
      _accountService = accountService;
      _fpService = fpService;
    }

    [HttpGet]
    [Authorize]
    public async Task<ActionResult<Account>> Get()
    {
      try
      {
        Account userInfo = await HttpContext.GetUserInfoAsync<Account>();
        return Ok(_accountService.GetOrCreateProfile(userInfo));
      }
      catch (Exception e)
      {
        return BadRequest(e.Message);
      }
    }

    [HttpGet("favorites")]
    [Authorize]
    public async Task<ActionResult<List<FavoriteProduct>>> GetMyFavorites()
    {
      try
      {
        Account userInfo = await HttpContext.GetUserInfoAsync<Account>();
        return Ok(_fpService.GetMyFavorites(userInfo.Id));
      }
      catch (Exception e)
      {
        return BadRequest(e.Message);
      }
    }
  }


}