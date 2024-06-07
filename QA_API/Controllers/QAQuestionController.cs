using Microsoft.AspNetCore.Mvc;
using QA_API.Model;

namespace QA_API.Controllers
{
    [Route("api")]
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
                        QuestionTitle = "What is ASP.NET Core?",
                        Question = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        MakeBy = "Shammi",
                        MakeDate = DateTime.UtcNow.AddHours(-2)
                    },
                    new QAQuestion
                    {
                        QuestionID = 2,
                        QuestionTitle = "How to deploy an ASP.NET Core application?",
                        Question = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        MakeBy = "Hasan",
                        MakeDate = DateTime.UtcNow.AddHours(-4)
                    },
                    new QAQuestion
                    {
                        QuestionID = 3,
                        QuestionTitle = "What is ASP.NET Core API?",
                        Question = "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                        MakeBy = "Sharmin",
                        MakeDate = DateTime.UtcNow.AddHours(-6)
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