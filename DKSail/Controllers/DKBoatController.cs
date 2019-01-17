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

namespace DKSail.Controllers
{
    public class DKBoatController : Controller
    {
        private readonly SailContext _context;

        public DKBoatController(SailContext context)
        {
            _context = context;
        }

        // GET: DKBoat
        public async Task<IActionResult> Index(int? memberId, string memberName)
        {
            var memberIdContext = _context.Member.Where(x => x.MemberId == memberId).FirstOrDefault();
            var memberNameContext = _context.Member.Where(x => x.FullName == memberName).FirstOrDefault();

            if (memberId == null && memberName == null)
            {
                if (HttpContext.Session.GetString("memberId") == null && HttpContext.Session.GetString("memberName") == null)
                {
                    TempData["Message"] = "Please select a member";
                    return RedirectToAction("Index", "DKMember");
                }
                else if (HttpContext.Session.GetString("memberId") != null && HttpContext.Session.GetString("memberName") == null)
                {
                    memberId = int.Parse(HttpContext.Session.GetString("memberId"));
                    memberName = _context.Member.Where(x => x.MemberId == memberId).FirstOrDefault().FullName;
                    HttpContext.Session.SetString("memberName", memberName);
                }
                else if (HttpContext.Session.GetString("memberId") == null && HttpContext.Session.GetString("memberName") != null)
                {
                    memberName = HttpContext.Session.GetString("memberName");
                    memberId = _context.Member.Where(x => x.FullName == memberName).FirstOrDefault().MemberId;
                    HttpContext.Session.SetString("memberId", memberId.ToString());
                }
                else
                {
                    memberId = int.Parse(HttpContext.Session.GetString("memberId"));
                    memberName = HttpContext.Session.GetString("memberName");
                }
            }
            else if (memberId == null && memberName != null)
            {
                if (memberNameContext == null)
                {
                    TempData["Message"] = "MemberName does not exist";
                    return RedirectToAction("Index", "DKMember");
                }
                memberId = _context.Member.Where(x => x.FullName == memberName).FirstOrDefault().MemberId;
                HttpContext.Session.SetString("memberId", memberId.ToString());
                HttpContext.Session.SetString("memberName", memberName);
            }
            else if (memberId != null && memberName == null)
            {
                if (memberIdContext == null)
                {
                    TempData["Message"] = "MemberId does not exist";
                    return RedirectToAction("Index", "DKMember");
                }
                memberName = _context.Member.Where(x => x.MemberId == memberId).FirstOrDefault().FullName;
                HttpContext.Session.SetString("memberId", memberId.ToString());
                HttpContext.Session.SetString("memberName", memberName);
            }
            else
            {
                if (memberIdContext == null)
                {
                    TempData["Message"] = "MemberId does not exist";
                    return RedirectToAction("Index", "DKMember");
                }

                var nameToFind = memberIdContext.FullName;
                if (memberName != nameToFind)
                {
                    TempData["Message"] = "MemberId does not match with MemberName";
                    return RedirectToAction("Index", "DKMember");
                }

                HttpContext.Session.SetString("memberId", memberId.ToString());
                HttpContext.Session.SetString("memberName", memberName);
            }

            ViewBag.memberId = memberId;
            ViewBag.memberName = memberName;

            var sailContext = await _context.Boat.Include(b => b.BoatType).Include(b => b.Member).Include(b => b.ParkingCodeNavigation).Where(x => x.MemberId == memberId).OrderBy(x => x.BoatClass).ToListAsync();
            return View(sailContext);
        }

        // GET: DKBoat/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");

            if (id == null)
            {
                return NotFound();
            }

            var boat = await _context.Boat
                .Include(b => b.BoatType)
                .Include(b => b.Member)
                .Include(b => b.ParkingCodeNavigation)
                .FirstOrDefaultAsync(m => m.BoatId == id);
            if (boat == null)
            {
                return NotFound();
            }

            return View(boat);
        }

        // GET: DKBoat/Create
        public IActionResult Create()
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");

            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name");
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName");
            ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.ActualBoatId == null), "ParkingCode", "ParkingCode");
            return View();
        }

        // POST: DKBoat/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("BoatId,MemberId,BoatClass,HullColour,SailNumber,HullLength,BoatTypeId,ParkingCode")] Boat boat)
        {
            boat.MemberId = int.Parse(HttpContext.Session.GetString("memberId"));

            if (ModelState.IsValid)
            {
                //to update actualBoatId in parking table
                var newParking = _context.Parking.Where(x => x.ParkingCode == boat.ParkingCode).FirstOrDefault();
                newParking.ActualBoatId = boat.BoatId.ToString();
                ////////////////////////////////////////

                _context.Add(boat);
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", boat.BoatTypeId);
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", boat.MemberId);
            ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.ActualBoatId == null), "ParkingCode", "ParkingCode", boat.ParkingCode);
            return View(boat);
        }

        // GET: DKBoat/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            
            if (id == null)
            {
                return NotFound();
            }

            var boat = await _context.Boat.FindAsync(id);

            if (boat == null)
            {
                return NotFound();
            }
            
            //to update actualBoatId in parking table
            var oldParkingCode = _context.Boat.Where(x => x.BoatId == id).FirstOrDefault().ParkingCode;
            HttpContext.Session.SetString("oldParkingCode", oldParkingCode);
            ////////////////////////////////////////

            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", boat.BoatTypeId);
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", boat.MemberId);

            if (boat.ParkingCode == "" || boat.ParkingCode == null)
            {
                ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.ActualBoatId == null), "ParkingCode", "ParkingCode", boat.ParkingCode); 
            }
            else
            {
                ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.BoatTypeId == boat.BoatTypeId && x.ActualBoatId == null), "ParkingCode", "ParkingCode", boat.ParkingCode);
            }
            return View(boat);
        }

        // POST: DKBoat/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("BoatId,MemberId,BoatClass,HullColour,SailNumber,HullLength,BoatTypeId,ParkingCode")] Boat boat)
        {
            if (id != boat.BoatId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    //to update actualBoatId in parking table
                    var oldParkingCode = HttpContext.Session.GetString("oldParkingCode");
                    var oldParking = _context.Parking.Where(x => x.ParkingCode == oldParkingCode).FirstOrDefault();
                    oldParking.ActualBoatId = null;

                    var newParking = _context.Parking.Where(x => x.ParkingCode == boat.ParkingCode).FirstOrDefault();
                    newParking.ActualBoatId = boat.BoatId.ToString();
                    ////////////////////////////////////////

                    _context.Update(boat);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BoatExists(boat.BoatId))
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
            ViewData["BoatTypeId"] = new SelectList(_context.BoatType.OrderBy(x => x.Name), "BoatTypeId", "Name", boat.BoatTypeId);
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", boat.MemberId);

            if (boat.ParkingCode == "" || boat.ParkingCode == null)
            {
                ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.ActualBoatId == null), "ParkingCode", "ParkingCode", boat.ParkingCode);
            }
            else
            {
                ViewData["ParkingCode"] = new SelectList(_context.Parking.Where(x => x.BoatTypeId == boat.BoatTypeId && x.ActualBoatId == null), "ParkingCode", "ParkingCode", boat.ParkingCode);
            }
                
            return View(boat);
        }

        // GET: DKBoat/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");

            if (id == null)
            {
                return NotFound();
            }

            var boat = await _context.Boat
                .Include(b => b.BoatType)
                .Include(b => b.Member)
                .Include(b => b.ParkingCodeNavigation)
                .FirstOrDefaultAsync(m => m.BoatId == id);
            if (boat == null)
            {
                return NotFound();
            }

            return View(boat);
        }

        // POST: DKBoat/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var boat = await _context.Boat.FindAsync(id);

            //to update actualBoatId in parking table
            var parkingCode = _context.Boat.Where(x => x.BoatId == id).FirstOrDefault().ParkingCode;
            _context.Parking.Where(x => x.ParkingCode == parkingCode).FirstOrDefault().ActualBoatId = null;
            ////////////////////////////////////////

            _context.Boat.Remove(boat);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool BoatExists(int id)
        {
            return _context.Boat.Any(e => e.BoatId == id);
        }
    }
}
