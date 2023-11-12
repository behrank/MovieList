//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Can Behran Kankul on 12.11.2023.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movieImage: UIImage?
    private var movieInfo: MovieInfo?
    private var onDismissCallback: (()->Void)?
    private var viewModel: MovieDetailViewModel?
    
    init(movieImage: UIImage? = nil, 
         movieData: MovieInfo?,
         dismissCallback: (()->Void)?) {
        self.movieImage = movieImage
        self.movieInfo = movieData
        self.onDismissCallback = dismissCallback
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = MovieDetailViewModel(prensenterVc: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupScrollView()
        setupContainerView()
        setupMovieImageView()
        setupStackView()
        setupContent()
        
        setupBackButton()
        
        if let id = movieInfo?.id {
            viewModel?.fetchMovieDetails(id)
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Scrollview
    lazy private var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        return scroll
    }()
    
    private func setupScrollView() {
        view.addSubviews(views: scrollView)
        scrollView.fillSuperview()
    }
    // MARK: - Containers
    lazy private var containerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private func setupContainerView() {
        scrollView.addSubviews(views: containerView)
        containerView.fillSuperview()
    }
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private func setupStackView() {
        containerView.addSubviews(views: stackView)
        stackView.setMargins(.left(value: 12),
                             .right(value: 12),
                             .bottom(value: 0))
        stackView.setMarginTo(view: movieImageView, with: .bottom(value: 12))
    }
    // MARK: - Back button
    lazy private var backButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(UIImage(named: "cancel"), for: .normal)
        btn.setImage(UIImage(named: "cancel"), for: .highlighted)
        btn.setImage(UIImage(named: "cancel"), for: .selected)
        return btn
    }()
    
    private func setupBackButton() {
        view.addSubviews(views: backButton)
        backButton.setMargins(.left(value: 16), .top(value: 48))
        backButton.addTarget(self,
                             action: #selector(userTappedBackBtn), for: .touchUpInside)
    }
    
    @objc private func userTappedBackBtn() {
        
        self.view.isHidden = true
        
        dismiss(animated: false) {
            self.onDismissCallback?()
            self.onDismissCallback = nil
        }
    }
    
    // MARK: - Content Generation
    lazy private var movieImageView: UIImageView = {
       return UIImageView(image: movieImage)
    }()
    
    private func setupMovieImageView() {
        containerView.addSubviews(views: movieImageView)
        movieImageView.setWidth(view.frame.width)
        movieImageView.setHeight((view.frame.width/2)*3)
        movieImageView.setMargins(.left(value: 0), .right(value: 0), .top(value: 0))
        movieImageView.setCornerRadius(radius: 4)
    }
    
    private func setupContent() {
        let titleLbl = AppLabel(text: movieInfo?.title ?? "",
                             font: .medium,
                             size: 24)
        
        let releaseDateLbl = AppLabel(text: movieInfo?.releaseDate ?? "",
                                      font: .regular,
                                      size: 12,
                                      color: UIColor.secondaryLabel)
        
        let overviewLbl = AppLabel(text: movieInfo?.overview ?? "",
                                   font: .regular,
                                   size: 16)
        
        let voteImage = UIImageView(image: UIImage(named: "thumbs-down"))
        let voteCountLbl = AppLabel(text: movieInfo?.voteAverage?.description ?? "",
                                    font: .bold,
                                    size: 12,
                                    color: UIColor.white)
        
        let voteStackView = UIStackView(arrangedSubviews: [voteImage, voteCountLbl])
        
        voteImage.setHeight(16)
        voteImage.setWidth(24)
        voteImage.setMargins(.left(value: 4))
        voteStackView.backgroundColor = .black
        voteStackView.setCornerRadius(radius: 4)
        voteStackView.spacing = 4
        voteStackView.axis = .horizontal
        voteStackView.contentMode = .scaleAspectFit
       
        containerView.addSubviews(views: voteStackView)
        voteStackView.setMargins(.right(value: 16))
        voteStackView.setMarginTo(view: stackView, with: .top(value: 32))
        voteStackView.setHeight(24)
        voteStackView.setWidth(54)
        
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(releaseDateLbl)
        stackView.addArrangedSubview(overviewLbl)
    }
}

extension MovieDetailViewController: Presenter {
    func presentData() {
        
        if let moviedetail = viewModel?.getMovieDetails() as? MovieDetailInfo {
            
            ///Genre
            let genres = moviedetail.genres?.compactMap({ genre in
                return genre.name
            })
            
            if let genres {
                let genreTitleLbl = AppLabel(text: "genre".uppercased(), 
                                             font: .regular,
                                             size: 12,
                                             color: UIColor.secondaryLabel)
                
                let genreLbl = AppLabel(text: genres.joined(separator: ", "),
                                        font: .medium,
                                        size: 14)
                
                stackView.addVerticalSpacer(height: 10)
                stackView.addArrangedSubview(genreTitleLbl)
                stackView.addArrangedSubview(genreLbl)
            }
            
            ///Runtime
            if let runtime = moviedetail.runtime {
            let runtimeTitleLbl = AppLabel(text: "runtime".uppercased(),
                                         font: .regular,
                                         size: 12,
                                         color: UIColor.secondaryLabel)
            
                let runtimeLbl = AppLabel(text: runtime.description.appending(" minutes"),
                                    font: .medium,
                                    size: 14)
            
                stackView.addVerticalSpacer(height: 10)
                stackView.addArrangedSubview(runtimeTitleLbl)
                stackView.addArrangedSubview(runtimeLbl)
            }
            
            ///Languages
            let languages = moviedetail.spokenLanguages?.compactMap({ lang in
                return lang.name
            })
            
            if let languages {
                let langTitleLbl = AppLabel(text: "available languages".uppercased(),
                                             font: .regular,
                                             size: 12,
                                             color: UIColor.secondaryLabel)
                
                let langLbl = AppLabel(text: languages.joined(separator: ", "),
                                        font: .medium,
                                        size: 14)
                
                stackView.addVerticalSpacer(height: 10)
                stackView.addArrangedSubview(langTitleLbl)
                stackView.addArrangedSubview(langLbl)
            }
            
            stackView.addVerticalSpacer(height: 10)
            
            ///budget - revenue
            let bugdetRevStackView = UIStackView(frame: .zero)
            bugdetRevStackView.axis = .horizontal
            bugdetRevStackView.distribution = .fillEqually
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "USD" // Türk Lirası için

            if let bugdet = formatter.string(from: NSNumber(value: moviedetail.budget ?? 0)) {
                let bugdetTitleLbl = AppLabel(text: "budget".uppercased(),
                                         font: .regular,
                                         size: 12,
                                         color: UIColor.secondaryLabel)
            
                let bugdetLbl = AppLabel(text: bugdet.description,
                                    font: .medium,
                                    size: 14)
            
                
                let bugdetStackView = UIStackView(frame: .zero)
                bugdetStackView.axis = .vertical
                bugdetStackView.distribution = .fillEqually
                
                bugdetStackView.addArrangedSubview(bugdetTitleLbl)
                bugdetStackView.addArrangedSubview(bugdetLbl)
                
                bugdetRevStackView.addArrangedSubview(bugdetStackView)
            }

            if let revenue = formatter.string(from: NSNumber(value: moviedetail.revenue ?? 0)) {
                let revenueTitleLbl = AppLabel(text: "revenue".uppercased(),
                                         font: .regular,
                                         size: 12,
                                         color: UIColor.secondaryLabel)
            
                let revenueLbl = AppLabel(text: revenue.description,
                                    font: .medium,
                                    size: 14)
            
                
                let revenueStackView = UIStackView(frame: .zero)
                revenueStackView.axis = .vertical
                revenueStackView.distribution = .fillEqually
                
                revenueStackView.addArrangedSubview(revenueTitleLbl)
                revenueStackView.addArrangedSubview(revenueLbl)
                
                bugdetRevStackView.addArrangedSubview(revenueStackView)
            }
            
            stackView.addArrangedSubview(bugdetRevStackView)
            
            ///Homepage
            if let homepage = moviedetail.homepage {
            let homepageTitleLbl = AppLabel(text: "homepage".uppercased(),
                                         font: .regular,
                                         size: 12,
                                         color: UIColor.secondaryLabel)
            
                let homepageLbl = AppLabel(text: homepage,
                                    font: .medium,
                                    size: 14)
            
                stackView.addVerticalSpacer(height: 10)
                stackView.addArrangedSubview(homepageTitleLbl)
                stackView.addArrangedSubview(homepageLbl)
            }
        }
        
        stackView.addVerticalSpacer(height: 32)
    }
    
    func presentLoading() {
        //No need
    }
    
    func hideLoading() {
        //No need
    }
}
