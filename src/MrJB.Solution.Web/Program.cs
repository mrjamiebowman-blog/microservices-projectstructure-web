using MrJB.Solution.Web;
using MrJB.Solution.Web.Components;
using MrJB.Solution.Web.Extensions;

var builder = WebApplication.CreateBuilder(args);

// Add service defaults & Aspire components.
//builder.AddServiceDefaults();
builder.AddRedisOutputCache("cache");

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

builder.Services.AddHttpClient<WeatherApiClient>(client=> client.BaseAddress = new("http://apiservice"));

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}

app.UseStaticFiles();
app.UseAntiforgery();
app.UseOutputCache();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

// aspire
app.MapDefaultEndpoints();

app.Run();
