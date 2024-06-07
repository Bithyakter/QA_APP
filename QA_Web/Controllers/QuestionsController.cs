using Microsoft.AspNetCore.Mvc;

namespace QA_Web.Controllers
{
    public class QuestionsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CreateQuestion()
        {
            return View();
        }
    }
}