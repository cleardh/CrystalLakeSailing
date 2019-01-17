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
    public class DKBoatTypeController : Controller
    {
        private readonly SailContext _context;

        public DKBoatTypeController(SailContext context)
        {
            _context = context;
        }
        /// <summary>
        /// Shows a list of Boat Types
        /// </summary>
        /// <returns>a view that contains a list of Boat Types</returns>
        // GET: DKBoatType
        public async Task<IActionResult> Index()
        {
            return View(await _context.BoatType.ToListAsync());
        }
        /// <summary>
        /// Shows details of a Boat Type when there is an id
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <returns>a view that contails details of the boat type with the corresponding id</returns>
        // GET: DKBoatType/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boatType = await _context.BoatType
                .FirstOrDefaultAsync(m => m.BoatTypeId == id);
            if (boatType == null)
            {
                return NotFound();
            }

            return View(boatType);
        }
        /// <summary>
        /// Shows a creat page with blank input fields
        /// </summary>
        /// <returns>a view that contains input fields for boat type creation</returns>
        // GET: DKBoatType/Create
        public IActionResult Create()
        {
            return View();
        }
        /// <summary>
        /// Saves newly created boat type to the list
        /// </summary>
        /// <param name="boatType">a boat type object created from user input</param>
        /// <returns>a view that contains the list of boat type including the newly added</returns>
        // POST: DKBoatType/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("BoatTypeId,Name,Description,Chargeable,Sail,Image")] BoatType boatType)
        {
            if (ModelState.IsValid)
            {
                _context.Add(boatType);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(boatType);
        }
        /// <summary>
        /// Shows a edit page with input fields filled with corresponding data
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <returns>a view that contains input fields for boat type edit</returns>
        // GET: DKBoatType/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boatType = await _context.BoatType.FindAsync(id);
            if (boatType == null)
            {
                return NotFound();
            }
            return View(boatType);
        }
        /// <summary>
        /// Saves newly edited boat type to the list
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <param name="boatType">a boat type object corresponding to id parameter</param>
        /// <returns>a view that contains the list of boat type including the newly edited</returns>
        // POST: DKBoatType/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("BoatTypeId,Name,Description,Chargeable,Sail,Image")] BoatType boatType)
        {
            if (id != boatType.BoatTypeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(boatType);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BoatTypeExists(boatType.BoatTypeId))
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
            return View(boatType);
        }
        /// <summary>
        /// Shows a delete page
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <returns>a view that contains the boat type details with the corresponding id</returns>
        // GET: DKBoatType/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var boatType = await _context.BoatType
                .FirstOrDefaultAsync(m => m.BoatTypeId == id);
            if (boatType == null)
            {
                return NotFound();
            }

            return View(boatType);
        }
        /// <summary>
        /// Saves the list excluding the newly deleted item from it
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <returns>a confirmation page</returns>
        // POST: DKBoatType/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var boatType = await _context.BoatType.FindAsync(id);
            _context.BoatType.Remove(boatType);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
        /// <summary>
        /// a helper method to identify whether a certain boat type with this id exists
        /// </summary>
        /// <param name="id">Boat type model id</param>
        /// <returns>a boolean value of whether the boat type exists</returns>
        private bool BoatTypeExists(int id)
        {
            return _context.BoatType.Any(e => e.BoatTypeId == id);
        }
    }
}
