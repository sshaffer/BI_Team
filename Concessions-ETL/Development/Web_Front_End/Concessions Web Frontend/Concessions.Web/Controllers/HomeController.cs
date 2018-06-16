using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Concessions.Web.Models;

namespace Concessions.Web.Controllers
{
    [Authorize(Roles="Dune IT")]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            DateTime startDate = DateTime.Now.Date;
            DateTime endDate = DateTime.Now.Date.AddDays(1);

            ConcessionsDataContext db = new ConcessionsDataContext();
            var logs = (from l in db.SSISPackageLogs
                       where l.StartTime >= startDate
                       && l.EndTime < endDate
                       select l).OrderBy(x => x.StartTime);

            return View(logs);            
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Index(DateTime? startDate, DateTime? endDate)
        {
            if (!startDate.HasValue)
                startDate = DateTime.Now.Date;

            if (!endDate.HasValue)
                endDate = startDate.Value.AddDays(1);

            if (endDate.Value <= startDate.Value)
                endDate = startDate.Value.AddDays(1);
            else
                endDate = endDate.Value.AddDays(1); // add a day so it gets included in the search

            ConcessionsDataContext db = new ConcessionsDataContext();
            var logs = from l in db.SSISPackageLogs
                       where l.StartTime >= startDate
                       && l.EndTime < endDate
                       select l;

            return View(logs);            
        }

        public ActionResult Details(int id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();
            var details = from d in db.SSISPackageLogDetails
                          where d.SSISPackageLogID == id
                          select d;

            if (details.Count() > 0) { return View(details); }

            return View("NoRecords");
        }

        public ActionResult Errors(int id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var errors = from e in db.SSISPackageLogDetailErrorRecords
                         where e.SSISPackageLogDetailRowId == id
                         select e;

            if (errors.Count() > 0) { return View(errors); }

            return View("NoRecords");
        }        
    }
}
