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
    public class DKMembershipTypeController : Controller
    {
        private readonly SailContext _context;

        public DKMembershipTypeController(SailContext context)
        {
            _context = context;
        }
        /// <summary>
        /// Shows a list of Membership Types
        /// </summary>
        /// <returns>a view that contains a list of Membership Types</returns>
        // GET: DKMembershipType
        public async Task<IActionResult> Index()
        {
            return View(await _context.MembershipType.ToListAsync());
        }
        /// <summary>
        /// Shows details of a Membership Type when there is an id
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <returns>a view that contails details of the Membership type with the corresponding id</returns>
        // GET: DKMembershipType/Details/5
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var membershipType = await _context.MembershipType
                .FirstOrDefaultAsync(m => m.MembershipTypeName == id);
            if (membershipType == null)
            {
                return NotFound();
            }

            return View(membershipType);
        }
        /// <summary>
        /// Shows a creat page with blank input fields
        /// </summary>
        /// <returns>a view that contains input fields for Membership type creation</returns>
        // GET: DKMembershipType/Create
        public IActionResult Create()
        {
            return View();
        }
        /// <summary>
        /// Saves newly created Membership Type to the list
        /// </summary>
        /// <param name="membershipType">a Membership type object created from user input</param>
        /// <returns>a view that contains the list of Membership type including the newly added</returns>
        // POST: DKMembershipType/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("MembershipTypeName,Description,RatioToFull")] MembershipType membershipType)
        {
            if (ModelState.IsValid)
            {
                _context.Add(membershipType);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(membershipType);
        }
        /// <summary>
        /// Shows a edit page with input fields filled with corresponding data
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <returns>a view that contains input fields for Membership type edit</returns>
        // GET: DKMembershipType/Edit/5
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var membershipType = await _context.MembershipType.FindAsync(id);
            if (membershipType == null)
            {
                return NotFound();
            }
            return View(membershipType);
        }
        /// <summary>
        /// Saves newly edited Membership type to the list
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <param name="membershipType">a Membership type object corresponding to id parameter</param>
        /// <returns>a view that contains the list of Membership type including the newly edited</returns>
        // POST: DKMembershipType/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(string id, [Bind("MembershipTypeName,Description,RatioToFull")] MembershipType membershipType)
        {
            if (id != membershipType.MembershipTypeName)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(membershipType);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MembershipTypeExists(membershipType.MembershipTypeName))
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
            return View(membershipType);
        }
        /// <summary>
        /// Shows a delete page
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <returns>a view that contains the Membership type details with the corresponding id</returns>
        // GET: DKMembershipType/Delete/5
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var membershipType = await _context.MembershipType
                .FirstOrDefaultAsync(m => m.MembershipTypeName == id);
            if (membershipType == null)
            {
                return NotFound();
            }

            return View(membershipType);
        }
        /// <summary>
        /// Saves the list excluding the newly deleted item from it
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <returns>a confirmation page</returns>
        // POST: DKMembershipType/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var membershipType = await _context.MembershipType.FindAsync(id);
            _context.MembershipType.Remove(membershipType);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
        /// <summary>
        /// a helper method to identify whether a certain Membership type with this id exists
        /// </summary>
        /// <param name="id">Membership type model id</param>
        /// <returns>a boolean value of whether the Membership type exists</returns>
        private bool MembershipTypeExists(string id)
        {
            return _context.MembershipType.Any(e => e.MembershipTypeName == id);
        }
    }
}
