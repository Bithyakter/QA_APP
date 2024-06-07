using Microsoft.AspNetCore.Mvc;

namespace QA_Web.Controllers
{
    public class AnswersController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CreateAnswer()
        {
            return View();
        }
    }
}
