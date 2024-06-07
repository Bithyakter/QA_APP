using QA_API.Model;

namespace QA_Web.Helper
{
    public class QuestionHttpService
    {
        private readonly HttpClient _httpClient;

        public QuestionHttpService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<QAQuestion>> GetQuestionsAsync()
        {
            return await _httpClient.GetFromJsonAsync<List<QAQuestion>>("http://localhost:5244/api/questions-list");
        }

        public async Task<QAQuestion> CreateQuestionAsync(QAQuestion question)
        {
            var response = await _httpClient.PostAsJsonAsync("http://localhost:5244/create-question", question);
            response.EnsureSuccessStatusCode();

            return await response.Content.ReadFromJsonAsync<QAQuestion>();
        }
    }
}
