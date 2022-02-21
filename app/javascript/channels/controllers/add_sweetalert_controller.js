import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';
import Typed from 'typed.js';

export default class extends Controller {
  static targets = ["cross", "list", "banner"]

  connect() {
    console.log("The 'sweetalert' controller is now loaded!")
    const options = {
      strings: ['Your Watchlist', 'Horror, thriller, you name it!'],
      typeSpeed: 40
    };
    const typed = new Typed(".typed-target", options);
  }

  alert(event) {
    const listId = event.currentTarget.dataset.id
    const findList = this.listTargets.find(list => list.dataset.id === listId)
    swal({
      title: "Are you sure?",
      text: "Once deleted, you will not be able to recover this list!",
      icon: "warning",
      buttons: true,
      dangerMode: true,
    })
    .then((willDelete) => {
      if (willDelete) {
        fetch(`/lists/${listId}`,
                {method: 'delete',
                    headers:  {
                        "Accept": "application/json"
                    }
                }
            )
                .then((result) => {
                  findList.style.transition = "all 2s"
                  setTimeout(() => findList.style.transform = "translateX(-1200px)", 1000)
                  setTimeout(() => findList.remove(), 1000)
                })

                .catch((err) => {
                    console.log(err)
                })
        swal("Poof! Your list has been deleted!", {
          icon: "success",
        });
        setTimeout(() => swal.close(), 1000)
      } else {
        swal("Your list is safe!");
        setTimeout(() => swal.close(), 1000)
      }
    });
  }

}
