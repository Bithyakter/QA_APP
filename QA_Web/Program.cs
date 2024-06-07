var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

//builder.Services.AddHttpClient();
//builder.Services.AddHttpClient<QuestionHttpService>();


//builder.Services.AddHttpClient<QuestionHttpService>(client =>
//{
//    client.BaseAddress = new Uri("http://localhost:5244/api/");
//});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Questions}/{action=Index}/{id?}");

app.Run();
