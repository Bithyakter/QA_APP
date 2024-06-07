using System.Text.Json.Serialization;

namespace QA_API.Model
{
    public class QAAnswer
    {
        public int AnswerID { get; set; }
        public string Answer { get; set; }
        public string MakeBy { get; set; }
        public DateTime MakeDate { get; set; }
        public string? AnswerAcceptedBy { get; set; }
        public DateTime? AnswerAcceptedDate { get; set; }
        public int QuestionID { get; set; }

        [JsonIgnore]
        public virtual QAQuestion? QAQuestion { get; set; }
    }
}