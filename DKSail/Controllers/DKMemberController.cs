/*
 * Program: DKSail
 * 
 * Name: Dongha Kang
 * Student Number: 8004178
 *        
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DKSail.Models;
using Microsoft.AspNetCore.Http;
using System.Text.RegularExpressions;

namespace DKSail.Controllers
{
    public class DKMemberController : Controller
    {
        private readonly SailContext _context;

        public DKMemberController(SailContext context)
        {
            _context = context;
        }

        // GET: DKMember
        public async Task<IActionResult> Index()
        {
            var sailContext = _context.Member.Include(m => m.ProvinceCodeNavigation);
            return View(await sailContext.OrderBy(x => x.FullName).ToListAsync());
        }

        // GET: DKMember/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var member = await _context.Member
                .Include(m => m.ProvinceCodeNavigation)
                .FirstOrDefaultAsync(m => m.MemberId == id);
            if (member == null)
            {
                return NotFound();
            }

            var memberName = member.FullName;
            ViewBag.memberName = memberName;

            return View(member);
        }

        // GET: DKMember/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: DKMember/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MemberId,FirstName,LastName,SpouseFirstName,SpouseLastName,Street,City,ProvinceCode,PostalCode,HomePhone,Email,YearJoined,Comment,TaskExempt,UseCanadaPost")] Member member)
        {
            // since MemberId is not an autonumber
            var lastMember = _context.Member.LastOrDefault().MemberId;
            member.MemberId = lastMember + 1;



            if (ModelState.IsValid)
            {
                _context.Add(member);
                await _context.SaveChangesAsync();
                TempData["Message"] = "Created Successfully";
                return RedirectToAction(nameof(Index));
            }
            return View(member);
        }

        // GET: DKMember/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var member = await _context.Member.FindAsync(id);
            if (member == null)
            {
                return NotFound();
            }

            var memberName = member.FullName;
            ViewBag.memberName = memberName;

            ViewData["ProvinceCode"] = new SelectList(_context.Province.OrderBy(x => x.Name), "ProvinceCode", "Name", member.ProvinceCode);
            return View(member);
        }

        // POST: DKMember/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MemberId,FullName,FirstName,LastName,SpouseFirstName,SpouseLastName,Street,City,ProvinceCode,PostalCode,HomePhone,Email,YearJoined,Comment,TaskExempt,UseCanadaPost")] Member member)
        {
            HttpContext.Session.SetString("currentMember", member.MemberId.ToString());

            if (id != member.MemberId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(member);
                    await _context.SaveChangesAsync();
                    TempData["Message"] = "Updated Successfully";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MemberExists(member.MemberId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["ProvinceCode"] = new SelectList(_context.Province.OrderBy(x => x.Name), "ProvinceCode", "Name", member.ProvinceCode);
            return View(member);
        }

        // GET: DKMember/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var member = await _context.Member
                .Include(m => m.ProvinceCodeNavigation)
                .FirstOrDefaultAsync(m => m.MemberId == id);
            if (member == null)
            {
                return NotFound();
            }

            var memberName = member.FullName;
            ViewBag.memberName = memberName;

            return View(member);
        }

        // POST: DKMember/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            try
            {
                var member = await _context.Member.FindAsync(id);
                _context.Member.Remove(member);
                await _context.SaveChangesAsync();
                TempData["Message"] = "Deleted Successfully";
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                if (ex.GetBaseException() != null)
                {
                    TempData["Message"] = ex.GetBaseException().Message;
                }

                //if(ex.InnerException != null)
                //{
                //    TempData["Message"] = ex.InnerException.ToString();
                //}
                //else
                //{
                //    TempData["Message"] = ex.ToString();
                //}                   

                return RedirectToAction(nameof(Index));
            }
        }

        private bool MemberExists(int id)
        {
            return _context.Member.Any(e => e.MemberId == id);
        }



        // Remote Validation

        private bool IsProvinceCodeValid(string provinceCode)
        {
            if (!string.IsNullOrWhiteSpace(provinceCode))
            {
                provinceCode = provinceCode.Trim().ToUpper();

                var provinceCodeOnRecord = _context.Province.Where(x => x.ProvinceCode == provinceCode).FirstOrDefault();


                if (provinceCodeOnRecord == null)
                {
                    return false;
                }
                else
                {
                    var country = _context.Province.Where(x => x.ProvinceCode == provinceCodeOnRecord.ProvinceCode).FirstOrDefault().CountryCode;
                    HttpContext.Session.SetString("countryCode", country);
                }
            }

            return true;
        }

        public JsonResult ValidateProvinceCode(string provinceCode, string postalCode)
        {
            if (!IsProvinceCodeValid(provinceCode))                
            {
                return Json("Province Code is not on file");
            }

            if (!IsPostalCodeValid(postalCode, provinceCode) && !string.IsNullOrEmpty(postalCode))
            {
                return Json("Province Code is not valid for this Postal Code");
            }
            return Json(true);

        }

        private bool IsPostalCodeValid(string postalCode, string provinceCode)
        {
            if (postalCode != null && postalCode != "")
            {
                if (!IsProvinceCodeValid(provinceCode))
                {
                    return false;
                }

                var country = HttpContext.Session.GetString("countryCode");

                if (country != null)
                {
                    var postalPattern = _context.Country.Where(x => x.CountryCode == country).FirstOrDefault().PostalPattern;
                    if (postalPattern != null)
                    {
                        if (country == "US")
                        {
                            postalCode = DKClassLibrary.DKValidations.DKExtractDigits(postalCode);
                        }
                        if (!Regex.IsMatch(postalCode.Trim(), postalPattern, RegexOptions.IgnoreCase))
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        public JsonResult ValidatePostalCode(string postalCode, string provinceCode)
        {
            if (!IsPostalCodeValid(postalCode, provinceCode))
            {
                return Json("Postal Code is not valid");
            }
            return Json(true);
        }
    }
}
