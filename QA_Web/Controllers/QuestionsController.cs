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


        //private readonly QuestionHttpService _qaService;

        //public QuestionsController(QuestionHttpService qaService)
        //{
        //    _qaService = qaService;
        //}

        //public async Task<IActionResult> Index()
        //{
        //    var questions = await _qaService.GetQuestionsAsync();
        //    return View(questions);
        //}

        //[HttpGet]
        //public IActionResult Create()
        //{
        //    return View();
        //}

        //[HttpPost]
        //public async Task<IActionResult> Create(QAQuestion question)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        await _qaService.CreateQuestionAsync(question);
        //        return RedirectToAction(nameof(Index));
        //    }
        //    return View(question);
        //}

    }
}