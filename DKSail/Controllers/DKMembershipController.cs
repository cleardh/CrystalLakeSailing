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
    public class DKMembershipController : Controller
    {
        private readonly SailContext _context;

        public DKMembershipController(SailContext context)
        {
            _context = context;
        }

        // GET: DKMembership
        public async Task<IActionResult> Index(int? memberId)
        {
            if (memberId == null)
            {
                if (HttpContext.Session.GetString("memberId") == null)
                {
                    TempData["Message"] = "Please choose a member";
                    return RedirectToAction("Index", "DKMember");
                }
                else
                {
                    memberId = int.Parse(HttpContext.Session.GetString("memberId"));
                }
            }
            else
            {
                HttpContext.Session.SetString("memberId", memberId.ToString());
            }

            var memberName = _context.Member.Where(x => x.MemberId == memberId).FirstOrDefault().FullName;
            HttpContext.Session.SetString("memberName", memberName);
            ViewBag.memberName = memberName;

            var sailContext = _context.Membership.Include(m => m.Member).Include(m => m.MembershipTypeNameNavigation);
            var sc = await sailContext.Where(x => x.MemberId == memberId || x.Member.FullName == memberName).OrderByDescending(Membership => Membership.Year).ToListAsync();
            return View(sc);
        }

        // GET: DKMembership/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            if (id == null)
            {
                return NotFound();
            }

            var membership = await _context.Membership
                .Include(m => m.Member)
                .Include(m => m.MembershipTypeNameNavigation)
                .FirstOrDefaultAsync(m => m.MembershipId == id);
            if (membership == null)
            {
                return NotFound();
            }

            return View(membership);
        }

        // GET: DKMembership/Create
        public IActionResult Create()
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName");
            List<MembershipType> membershipTypeList = _context.MembershipType.OrderBy(x => x.MembershipTypeName).ToList();
            ViewData["MembershipTypeName"] = new SelectList(membershipTypeList, "MembershipTypeName", "MembershipTypeName");
            return View();
        }

        // POST: DKMembership/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MembershipId,MemberId,Year,MembershipTypeName,Fee,Comments,Paid")] Membership membership)
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            membership.MemberId = int.Parse(ViewBag.memberId);
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            
            // AnnualFee Calculation Begin
            var annualFee = _context.AnnualFeeStructure.Where(a => a.Year == membership.Year).FirstOrDefault().AnnualFee;

            var ratioToFull = _context.MembershipType.Where(x => x.MembershipTypeName == membership.MembershipTypeName).FirstOrDefault().RatioToFull;

            var numberOfBoats = _context.Boat.Where(b => b.MemberId == membership.MemberId).ToList().Count();

            annualFee *= ratioToFull;

            if (numberOfBoats == 2)
            {
                annualFee += _context.AnnualFeeStructure.Where(a => a.Year == membership.Year).FirstOrDefault().SecondBoatFee;
            }
            else if (numberOfBoats == 3)
            {
                annualFee += _context.AnnualFeeStructure.Where(a => a.Year == membership.Year).FirstOrDefault().ThirdBoatFee;
            }
            else if (numberOfBoats >= 4)
            {
                annualFee += _context.AnnualFeeStructure.Where(a => a.Year == membership.Year).FirstOrDefault().ForthAndSubsequentBoatFee;
            }
            // AnnualFee Calculation End

            if (ModelState.IsValid)
            {
                membership.Fee = (float)annualFee; // overriding user input fee with calculated value
                _context.Add(membership);
                await _context.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", membership.MemberId);
            ViewData["MembershipTypeName"] = new SelectList(_context.MembershipType, "MembershipTypeName", "MembershipTypeName", membership.MembershipTypeName);
            return RedirectToAction("Index");
        }

        // GET: DKMembership/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            if (id == null)
            {
                return NotFound();
            }

            var membership = await _context.Membership.FindAsync(id);
            HttpContext.Session.SetInt32("membershipYear", membership.Year);
            if (membership == null)
            {
                return NotFound();
            }
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", membership.MemberId);
            List<MembershipType> membershipTypeList = _context.MembershipType.OrderBy(x => x.MembershipTypeName).ToList();
            ViewData["MembershipTypeName"] = new SelectList(membershipTypeList, "MembershipTypeName", "MembershipTypeName", membership.MembershipTypeName);
            return View(membership);
        }

        // POST: DKMembership/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("MembershipId,MemberId,Year,MembershipTypeName,Fee,Comments,Paid")] Membership membership)
        {
            ViewBag.memberId = HttpContext.Session.GetString("memberId");
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            ViewBag.membershipYear = HttpContext.Session.GetInt32("membershipYear");
            if (ViewBag.membershipYear != membership.Year)
            {
                TempData["Message"] = "You Can't Change Year";
                return RedirectToAction("Index", new { memberId = ViewBag.memberId, memberName = ViewBag.memberName });
            }

            if (id != membership.MembershipId)
            {
                return NotFound();
            }
            
            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(membership);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MembershipExists(membership.MembershipId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction("Index", new { memberId = ViewBag.memberId, memberName = ViewBag.memberName });
            }
            ViewData["MemberId"] = new SelectList(_context.Member, "MemberId", "FirstName", membership.MemberId);
            ViewData["MembershipTypeName"] = new SelectList(_context.MembershipType, "MembershipTypeName", "MembershipTypeName", membership.MembershipTypeName);
            return RedirectToAction("Index", new { memberId = ViewBag.memberId, memberName = ViewBag.memberName });
        }

        // GET: DKMembership/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            if (id == null)
            {
                return NotFound();
            }

            var membership = await _context.Membership
                .Include(m => m.Member)
                .Include(m => m.MembershipTypeNameNavigation)
                .FirstOrDefaultAsync(m => m.MembershipId == id);
            if (membership == null)
            {
                return NotFound();
            }

            return View(membership);
        }

        // POST: DKMembership/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            ViewBag.memberName = HttpContext.Session.GetString("memberName");
            var membership = await _context.Membership.FindAsync(id);
            _context.Membership.Remove(membership);
            await _context.SaveChangesAsync();
            return RedirectToAction("Index", new { memberId = ViewBag.memberId, memberName = ViewBag.memberName });
        }

        private bool MembershipExists(int id)
        {
            return _context.Membership.Any(e => e.MembershipId == id);
        }
    }
}
