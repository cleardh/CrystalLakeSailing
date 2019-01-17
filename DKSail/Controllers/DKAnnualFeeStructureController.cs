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

namespace DKSail.Controllers
{
    public class DKAnnualFeeStructureController : Controller
    {
        private readonly SailContext _context;

        public DKAnnualFeeStructureController(SailContext context)
        {
            _context = context;
        }

        // GET: DKAnnualFeeStructure
        public async Task<IActionResult> Index()
        {
            return View(await _context.AnnualFeeStructure.OrderByDescending(AnnualFeeStructure => AnnualFeeStructure.Year).ToListAsync());
        }

        // GET: DKAnnualFeeStructure/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var annualFeeStructure = await _context.AnnualFeeStructure
                .FirstOrDefaultAsync(m => m.Year == id);
            if (annualFeeStructure == null)
            {
                return NotFound();
            }

            return View(annualFeeStructure);
        }

        // GET: DKAnnualFeeStructure/Create
        public IActionResult Create()
        {
            AnnualFeeStructure afs = _context.AnnualFeeStructure.OrderByDescending(x => x.Year).FirstOrDefault();
            return View(afs);
        }

        // POST: DKAnnualFeeStructure/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Year,AnnualFee,EarlyDiscountedFee,EarlyDiscountEndDate,RenewDeadlineDate,TaskExemptionFee,SecondBoatFee,ThirdBoatFee,ForthAndSubsequentBoatFee,NonSailFee,NewMember25DiscountDate,NewMember50DiscountDate,NewMember75DiscountDate")] AnnualFeeStructure annualFeeStructure)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    _context.Add(annualFeeStructure);
                    await _context.SaveChangesAsync();
                    return RedirectToAction(nameof(Index));
                }
                return View(annualFeeStructure);
            }
            catch (Exception ex)
            {
                TempData["Message"] = ex.Message;
                return RedirectToAction(nameof(Create));
            }
        }

        // GET: DKAnnualFeeStructure/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var annualFeeStructure = await _context.AnnualFeeStructure.FindAsync(id);
            if (annualFeeStructure == null)
            {
                return NotFound();
            }
            return View(annualFeeStructure);
        }

        // POST: DKAnnualFeeStructure/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Year,AnnualFee,EarlyDiscountedFee,EarlyDiscountEndDate,RenewDeadlineDate,TaskExemptionFee,SecondBoatFee,ThirdBoatFee,ForthAndSubsequentBoatFee,NonSailFee,NewMember25DiscountDate,NewMember50DiscountDate,NewMember75DiscountDate")] AnnualFeeStructure annualFeeStructure)
        {
            if (id != annualFeeStructure.Year)
            {
                TempData["Message"] = "You Can't Change Year";
                return RedirectToAction("Index");
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(annualFeeStructure);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AnnualFeeStructureExists(annualFeeStructure.Year))
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
            return View(annualFeeStructure);
        }

        // GET: DKAnnualFeeStructure/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var annualFeeStructure = await _context.AnnualFeeStructure
                .FirstOrDefaultAsync(m => m.Year == id);
            if (annualFeeStructure == null)
            {
                return NotFound();
            }

            return View(annualFeeStructure);
        }

        // POST: DKAnnualFeeStructure/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var annualFeeStructure = await _context.AnnualFeeStructure.FindAsync(id);
            _context.AnnualFeeStructure.Remove(annualFeeStructure);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool AnnualFeeStructureExists(int id)
        {
            return _context.AnnualFeeStructure.Any(e => e.Year == id);
        }
    }
}
