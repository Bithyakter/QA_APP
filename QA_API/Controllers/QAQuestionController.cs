using Microsoft.AspNetCore.Mvc;
using QA_API.Model;

namespace QA_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QAQuestionController : ControllerBase
    {
        private readonly List<QAQuestion> _questions;

        public QAQuestionController()
        {
            _questions = new List<QAQuestion>
                {
                    new QAQuestion
                    {
                        QuestionID = 1,
                        Question = "What is ASP.NET Core?",
                        MakeBy = "Shammi",
                        MakeDate = DateTime.Now,
                    },
                    new QAQuestion
                    {
                        QuestionID = 2,
                        Question = "How to deploy an ASP.NET Core application?",
                        MakeBy = "Hasan",
                        MakeDate = DateTime.Now,
                    },
                    new QAQuestion
                    {
                        QuestionID = 3,
                        Question = "Waht is ASP.NET Core API?",
                        MakeBy = "Sharmin",
                        MakeDate = DateTime.Now,
                    }
                };
        }

        #region Create Question
        [Route("create-question")]
        [HttpPost]
        public IActionResult CreateQuestion(QAQuestion question)
        {
            question.QuestionID = _questions.Count + 1;
            question.MakeDate = DateTime.Now;

            _questions.Add(question);

            //return Ok(new { Status = "Success", output = question.Question });
            return Ok(question);
        }
        #endregion

        #region Get List of Question
        [Route("questions-list")]
        [HttpGet]
        public IActionResult GetQuestionList()
        {
            return Ok(_questions);
        }
        #endregion

    }
}