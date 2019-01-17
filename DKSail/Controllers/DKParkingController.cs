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
    public class DKParkingController : Controller
    {
        private readonly SailContext _context;

        public DKParkingController(SailContext context)
        {
            _context = context;
        }

        // GET: DKParking
        public async Task<IActionResult> Index()
        {
            var sailContext = _context.Parking.Include(p => p.BoatType).OrderBy(x => x.ParkingCode);
            return View(await sailContext.ToListAsync());
        }

        // GET: DKParking/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                //return NotFound();
                TempData["Message"] = "Please select a record with valid parking code";
                return RedirectToAction("Index", "DKParking");
            }

            var parking = await _context.Parking
                .Include(p => p.BoatType)
                .FirstOrDefaultAsync(m => m.ParkingCode == id);
            if (parking == null)
            {
                return NotFound();
            }

            return View(parking);
        }

        // GET: DKParking/Create
        public IActionResult Create()
        {
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name");
            return View();
        }

        // POST: DKParking/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("ParkingCode,BoatTypeId,ActualBoatId")] Parking parking)
        {
            if (ModelState.IsValid)
            {
                _context.Add(parking);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", parking.BoatTypeId);
            return View(parking);
        }

        // GET: DKParking/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                //return NotFound();
                TempData["Message"] = "Please select a record with valid parking code";
                return RedirectToAction("Index", "DKParking");
            }

            var parking = await _context.Parking.FindAsync(id);
            if (parking == null)
            {
                return NotFound();
            }
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", parking.BoatTypeId);
            return View(parking);
        }

        // POST: DKParking/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("ParkingCode,BoatTypeId,ActualBoatId")] Parking parking)
        {
            if (id != parking.ParkingCode)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(parking);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ParkingExists(parking.ParkingCode))
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
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", parking.BoatTypeId);
            return View(parking);
        }

        // GET: DKParking/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                //return NotFound();
                TempData["Message"] = "Please select a record with valid parking code";
                return RedirectToAction("Index", "DKParking");
            }

            var parking = await _context.Parking
                .Include(p => p.BoatType)
                .FirstOrDefaultAsync(m => m.ParkingCode == id);
            if (parking == null)
            {
                return NotFound();
            }

            return View(parking);
        }

        // POST: DKParking/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var parking = await _context.Parking.FindAsync(id);
            _context.Parking.Remove(parking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool ParkingExists(string id)
        {
            return _context.Parking.Any(e => e.ParkingCode == id);
        }
    }
}
