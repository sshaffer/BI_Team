using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
//using Concessions.Data.DAL;
//using Concessions.Data.Models;
using Concessions.Web.Models;

namespace Concessions.Web.Controllers
{
    [Authorize(Roles = "Dune IT")]
    public class ConfigurationController : Controller
    {
        //
        // GET: /Configuration/

        public ActionResult Index()
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var concessions = from c in db.Concessions
                              select c;

            return View(concessions.OrderBy(x => x.Name));
        }

        public ActionResult Show(string id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var config = from cc in db.ConcessionConfigurations
                         where cc.ConcessionName == id
                         select cc;

            if (config.Count() > 0) { return View(config.OrderBy(x => x.Configuration.Name)); }

            return View("NoRecords");
        }

        public ActionResult Edit(string concession, int id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var configuration = (from cc in db.ConcessionConfigurations
                                where cc.ConfigurationId == id
                                && cc.ConcessionName == concession                                
                                select cc).Single();

            return View(configuration);           
        }

        [HttpPost]
        public ActionResult Edit(int id, string concession, string description, string value)
        {

            ConcessionsDataContext db = new ConcessionsDataContext();

            var configuration = (from cc in db.ConcessionConfigurations
                                 where cc.ConfigurationId == id
                                 && cc.ConcessionName == concession
                                 select cc).Single();

            configuration.value = value;
            configuration.Configuration.Description = description;

            db.SubmitChanges();

            return RedirectToAction("Show", new { id = configuration.Concession.Name });

        }

        public ActionResult Delete(string concession, int id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var concessionConfigurations = (from cc in db.ConcessionConfigurations
                                 where cc.ConfigurationId == id
                                 select cc).Single();

            db.ConcessionConfigurations.DeleteOnSubmit(concessionConfigurations);
            db.SubmitChanges();

            return RedirectToAction("Show", new { id = concession });
        }

        public ActionResult Add(string id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var concession = (from c in db.Concessions
                              where c.Name == id
                              select c).First();

            var configurations = (from c in db.Configurations
                                  select new
                                  {
                                      c.ConfigurationId,
                                      c.Name
                                  }).OrderBy(x => x.Name);

            List<SelectListItem> listItems = new List<SelectListItem>();
            foreach (var item in configurations)
            {
                listItems.Add(new SelectListItem
                {
                    Text = item.Name,
                    Value =item.ConfigurationId.ToString()

                });
            }

            ViewData["Configurations"] = listItems.AsEnumerable();            

            return View(concession);
        }

        [HttpPost]
        public ActionResult Add(string concession, int configurations, string newConfiguration, string newConfigurationDesc, string value)
        {
            try
            {

                int configurationId;

                ConcessionsDataContext db = new ConcessionsDataContext();

                if (!String.IsNullOrEmpty(newConfiguration))
                {
                    var config = new Configuration();
                    config.Name = newConfiguration;
                    config.Description = newConfigurationDesc;

                    db.Configurations.InsertOnSubmit(config);
                    db.SubmitChanges();

                    configurationId = config.ConfigurationId;
                }
                else
                {
                    configurationId = configurations;
                }

                var concessionConfigurations = new ConcessionConfiguration();
                concessionConfigurations.ConfigurationId = configurationId;
                concessionConfigurations.value = value;
                concessionConfigurations.ConcessionName = concession;

                db.ConcessionConfigurations.InsertOnSubmit(concessionConfigurations);
                db.SubmitChanges();

            }
            catch
            {
                TempData["ErrorMessage"] = "Configuration already exists.";
            }

            return RedirectToAction("Show", "Configuration", new { id = concession });

        }

        public ActionResult ManageConfigurations()
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var result = from c in db.Configurations
                         select c;

            return View(result.OrderBy(x => x.Name));
        }

        
        public ActionResult EditConfiguration(int id)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            var result = (from c in db.Configurations
                         where c.ConfigurationId == id
                         select c).First();

            return View(result);
        }

        [HttpPost]
        public ActionResult EditConfiguration(int id, string submit, Configuration config)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();

            if (submit == "Delete")
            {
                // Check if other stuff is using this configuration
                var result = from c in db.ConcessionConfigurations
                           where c.ConfigurationId == id
                           select c;

                if (result.Count() > 0)
                {
                    TempData["ErrorMessage"] = "Unable to delete configuration. It is in use.";
                    return View(config);
                }
                else
                {
                    var item = (from c in db.Configurations
                                where c.ConfigurationId == id
                                select c).Single();

                    db.Configurations.DeleteOnSubmit(item);
                    db.SubmitChanges();

                    TempData["SuccessMessage"] = "Configuration has been deleted.";

                    return RedirectToAction("ManageConfigurations");
                }
            }
            else
            {
                var item = (from c in db.Configurations
                            where c.ConfigurationId == id
                            select c).Single();

                item.Description = config.Description;

                db.SubmitChanges();

                TempData["SuccessMessage"] = "Configuration has been saved";

                return RedirectToAction("ManageConfigurations");
            }
        }

        public ActionResult AddConfiguration()
        {
            return View();
        }

        [HttpPost]
        public ActionResult AddConfiguration(string name, string description)
        {
            Configuration conf = new Configuration();
            conf.Name = name;
            conf.Description = description;

            ConcessionsDataContext db = new ConcessionsDataContext();
            db.Configurations.InsertOnSubmit(conf);
            db.SubmitChanges();

            TempData["SuccessMessage"] = "Configuration has been saved.";

            return RedirectToAction("ManageConfigurations");
        }

        public ActionResult AddConcession()
        {

            return View();
        }

        [HttpPost]
        public ActionResult AddConcession(string Name, string Description, int IsEnabled)
        {
            ConcessionsDataContext db = new ConcessionsDataContext();
            
            Concession con = new Concession();
            con.Name = Name;
            con.Description = Description;

            db.Concessions.InsertOnSubmit(con);
            db.SubmitChanges();

            ConcessionConfiguration conf = new ConcessionConfiguration();
            conf.ConcessionName = con.Name;
            conf.ConfigurationId = 1;
            conf.value = IsEnabled.ToString();

            db.ConcessionConfigurations.InsertOnSubmit(conf);
            db.SubmitChanges();

            TempData["SuccessMessage"] = "Concession has been saved.";

            return RedirectToAction("Index");
        }
    }
}
